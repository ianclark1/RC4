<!---
ColdFusion RC4 Component

Written by Steve Hicks (steve@aquafusionmedia.com)
http://www.aquafusionmedia.com

Version 1.0 - Released: April 24, 2012
--->

<cfcomponent output="false">
	<!--- Encrypt a String (src) using the Key (key) --->
	<cffunction name="RC4encrypt" access="public" returntype="string">
		<cfargument name="src" required="yes">
		<cfargument name="key" required="yes">
		<cfset mtxt = strToChars(arguments.src)>
		<cfset mkey = strToChars(arguments.key)>
		<cfset result = RC4calculate(mtxt,mkey)>
		<cfreturn charsToHex(result)>
	</cffunction>
	
	<!--- Decrypt a String (src) using the Key (key) --->
	<cffunction name="RC4decrypt" access="public" returntype="string">
		<cfargument name="src" required="yes">
		<cfargument name="key" required="yes">
		<cfset mtxt = hexToChars(arguments.src)>
		<cfset mkey = strToChars(arguments.key)>
		<cfset result = RC4calculate(mtxt,mkey)>
		<cfreturn charsToStr(result)>
	</cffunction>

	<!--- Set Up the Component Ready for Encryption --->
	<cffunction name="RC4initialize" access="public" returntype="any">
		<cfargument name="pwd" required="yes">
		<cfset sbox = arraynew(1)>
		<cfset mykey = arraynew(1)>
		<cfset b = 0>
		<cfset intLength = arraylen(arguments.pwd)>
		<cfloop from="0" to="255" index="a">
			<cfset mykey[a + 1] = arguments.pwd[(a mod intLength) + 1]>
			<cfset sbox[a + 1] = a>
		</cfloop>
		<cfloop from="0" to="255" index="a">
			<cfset b = ( b + sbox[a + 1] + mykey[a+1] ) mod 256>
			<cfset tempswap = sbox[a + 1]>
			<cfset sbox[a + 1] = sbox[b + 1]>
			<cfset sbox[b + 1] = tempswap>
		</cfloop>	
		<cfreturn sbox>
	</cffunction>
	
	<!--- Calculate the Cipher --->
	<cffunction name="RC4calculate" access="public" returntype="any">
		<cfargument name="plaintext" required="yes">
		<cfargument name="psw" required="yes">
		<cfset sbox = RC4initialize(arguments.psw)>
		<cfset i = 0>
		<cfset j = 0>
		<cfset cipher = arraynew(1)>
		<cfloop from="1" to="#arraylen(plaintext)#" index="a">
			<cfset i = (i + 1) mod 256>
			<cfset j = (j + sbox[i + 1]) mod 256>
			<cfset temp = sbox[i + 1]>
			<cfset sbox[i + 1] = sbox[j + 1]>
			<cfset sbox[j + 1] = temp>
			<cfset k = sbox[((sbox[i + 1] + sbox[j + 1]) mod 256) + 1]>
			<cfset cipherby = BitXor(arguments.plaintext[a],k)>
			<cfset arrayappend(cipher,cipherby)>
		</cfloop>
		<cfreturn cipher>
	</cffunction>

	<!--- Convert an Array of Chars into a Hex String --->
	<cffunction name="charsToHex" access="public" returntype="string">
		<cfargument name="chars" type="array" required="yes">
		<cfset result = ''>
		<cfloop from="1" to="#arraylen(arguments.chars)#" index="i">
			<cfset fbn = formatBaseN(chars[i],16)>
			<cfif len(fbn) eq 1>
				<cfset fbn = '0#fbn#'>
			</cfif>
			<cfset result = result & fbn>
		</cfloop>
		<cfreturn result>
	</cffunction>
	
	<!--- Convert a Hex String into an Array of Characters --->
	<cffunction name="hexToChars" access="public" returntype="array">
		<cfargument name="hex" type="string" required="yes">
		<cfset chars = arraynew(1)>
		<cfloop from="1" to="#len(arguments.hex)#" index="i" step="2">
			<cfset arrayappend(chars,inputBaseN(mid(arguments.hex,i,2),16))>
		</cfloop>
		<cfreturn chars>
	</cffunction>
	
	<!--- Convert an Array of Characters into a String --->
	<cffunction name="charsToStr" access="public" returntype="string">
		<cfargument name="chars" type="array" required="yes">
		<cfset result = ''>
		<cfloop from="1" to="#arraylen(arguments.chars)#" index="i">
			<cfset result = result & chr(chars[i])>
		</cfloop>
		<cfreturn result>
	</cffunction>
	
	<!--- Convert a String into an Array of Characters --->
	<cffunction name="strToChars" access="public" returntype="array">
		<cfargument name="str" type="string" required="yes">
		<cfset codes = arraynew(1)>
		<cfloop from="1" to="#len(arguments.str)#" index="i">
			<cfset codes[i] = asc(mid(arguments.str,i,1))>
		</cfloop>		
		<cfreturn codes>
	</cffunction>
</cfcomponent>