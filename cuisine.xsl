<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" />

<!--
    File Name:      cuisine.xsl
    Author:         Jacobus Janse van Vuren
    Date Created:   10-09-2017
-->

    <xsl:template match="cuisine">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
			    <link rel="stylesheet" type="text/css" href="style.css" />
                <link rel="icon" type="image/png" href="images/icon.png" />
                <title><xsl:value-of select="cuisineType/@type"/> Restaurants</title>
            </head>

            <body>

                <h1><xsl:value-of select="cuisineType/@type"/> Restaurants</h1>

                <!-- Website navigation bar -->
                <nav>
                    <a class="nav" href="index.html">Home</a>
                    <a class="nav" href="Asian.xml">Asian</a>
                    <a class="nav" href="Burgers.xml">Burgers</a>
                    <a class="nav" href="dataCollection.html">Customer Survey</a>
                    <a class="nav" href="#copyright">Copyright</a>
                    <a class="nav" href="https://www.visser.com.au/blog/generic-privacy-policy-for-australian-websites/">Privacy Policy</a>
                    <a class="nav" href="https://media.termsfeed.com/pdf/terms-and-conditions-template.pdf">Terms &#38; Conditions</a>
                    <a class="nav" href="http://www.blogtyrant.com/best-about-us-pages/">About us</a>
                    <a class="nav" href="http://www.blogtyrant.com/best-contact-us-pages/">Contact us</a>
                </nav>

                <!-- use for-each to list the information for all restaurants contained in xml file -->
                <xsl:for-each select="restaurant">

                    <!-- Sort the restaurants by their name -->
                    <xsl:sort select="@name"/>
                        <!-- Use a paragraph to provide required formatting -->
                        <p>
                            <!-- Heading containing restaurant name -->
                            <h2><xsl:value-of select="@name"/></h2>

                            <!-- If the restaurant logo is provided use display it.
                                 Otherwise display the picture/s -->
                            <xsl:choose>
                                <xsl:when test="logo">
                                    <img src="{logo}" alt="Logo not found"/><br/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="picture">
                                        <img src="{.}" alt="Picture not found"/><br/>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                            <br/>
                            <xsl:value-of select="description"/> <br/>
                            <br/>

                            <!-- Display the restaurants URL. (URL's are made up and probably do not exist) -->
                            <xsl:text>Website: </xsl:text><a class="light" href="{@url}"><xsl:value-of select="@url"/></a><br/>
                            <br/>
                            <!-- Show the customer rating out of 5 stars -->
                            <xsl:text>Customer Rating: </xsl:text><xsl:value-of select="@rating"/><xsl:text>/5</xsl:text>
                            <br/><br/>

                            <!-- If the restaurant is open 24/7 display "Open 24 hours..."
                                 Otherwise show the open and close times -->
                            <xsl:text>Business Hours: </xsl:text><br/>
                            <xsl:for-each select="openingHours/openTimes">
                                <xsl:choose>
                                    <xsl:when test="(@day='Monday-Sunday')
                                    and (closeTime/time/@hours='11')
                                    and (closeTime/time/@minutes='59')">
                                        <xsl:text> Open 24 hours 7 days a week. </xsl:text><br/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="@day"/><xsl:text> from </xsl:text>
                                        <xsl:value-of select="openTime/time/@hours"/><xsl:text>:</xsl:text>
                                        <xsl:value-of select="openTime/time/@minutes"/><xsl:text> </xsl:text>
                                        <xsl:value-of select="openTime/time/@amPm"/><xsl:text> - </xsl:text>
                                        <xsl:value-of select="closeTime/time/@hours"/><xsl:text>:</xsl:text>
                                        <xsl:value-of select="closeTime/time/@minutes"/><xsl:text> </xsl:text>
                                        <xsl:value-of select="closeTime/time/@amPm"/>
                                        <br/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                            <br/>

                            <!-- If delivery is free show "Free".
                                 Otherwise show the minimum price and the fee -->
                            <xsl:text>Delivery: </xsl:text> <br/>
                            <xsl:choose>
                                <xsl:when test="(delivery/minimumPrice/@dollars='00')
                                and (delivery/minimumPrice/@cents='00')
                                and (delivery/fee/@dollars='00')
                                and (delivery/fee/@cents='00')">
                                    <xsl:text>Free </xsl:text> <br/><br/>
                                </xsl:when>
                                <xsl:otherwise>
                                <xsl:text>Minimum price - $</xsl:text>
                                <xsl:value-of select="delivery/minimumPrice/@dollars"/>
                                <xsl:text>.</xsl:text>
                                <xsl:value-of select="delivery/minimumPrice/@cents"/> <br/>
                                <xsl:text>Fee - $</xsl:text>
                                <xsl:value-of select="delivery/fee/@dollars"/>
                                <xsl:text>.</xsl:text>
                                <xsl:value-of select="delivery/fee/@cents"/> <br/>
                                <br/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text>Address:</xsl:text><br/>
                            <xsl:value-of select="address/@streetNo"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="address/@streetName"/><br/>
                            <xsl:value-of select="address/@city"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="address/@zipCode"/><br/>
                            <br/>

                            <!-- Show all the restaurants phone numbers -->
                            <xsl:text>Phone Numbers: </xsl:text>  <br/>
                            <xsl:for-each select="phoneNo">
                                <xsl:value-of select="@type"/>
                                <xsl:text> - </xsl:text>
                                <xsl:value-of select="."/><br/>
                            </xsl:for-each>
                        </p>
                </xsl:for-each>

                <!--  Webpage footer section -->
                <div class="footer">
                    <!-- Webpage copyright info -->
                    <p id="copyright" class="copyright">
                        Copyright&#169; Jacobus Janse van Vuren <br/>
                        <a href="mailto:jacobus.jansevanvuren@uon.edu.au">jacobus.jansevanvuren@uon.edu.au</a> <br/>
                        c3252194 <br/>
                        Information Technology
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>