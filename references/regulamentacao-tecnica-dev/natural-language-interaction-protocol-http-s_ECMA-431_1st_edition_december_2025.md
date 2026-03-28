# natural-language-interaction-protocol-http-s_ECMA-431_1st_edition_december_2025

> Fonte: `natural-language-interaction-protocol-http-s_ECMA-431_1st_edition_december_2025.pdf`

          ECMA-431
          1st Edition / December 2025




Binding of the Natural
Language Interaction
Protocol (NLIP) over
HTTP/HTTPS




                           Reference number
                            ECMA-123:2009



                    © Ecma International 2009
COPYRIGHT PROTECTED DOCUMENT


                               © Ecma International 2025
Contents                                                                                                                                                      Page


1        Scope ...................................................................................................................................................... 1
2        Conformance ......................................................................................................................................... 1
3        Normative references ............................................................................................................................ 1
4        Terms and definitions ........................................................................................................................... 1
5        Notational conventions ......................................................................................................................... 2
6        NLIP end point ....................................................................................................................................... 2
6.1      Optional end points ............................................................................................................................... 2




© Ecma International 2025                                                                                                                                             i
Introduction
The technology of Artificial Intelligence has the potential to be truly transformative to society. Despite some
limitations, the technology is capable of many functions, including but not limited to answering questions,
translating, describing and summarizing multi-modal content, generating new content, and summarizing large
volumes of information. This enables the creation of intelligent agents that can use AI to analyze data and
provide new services.

A much bigger boost to the social benefits of AI technology can be obtained by interactions among different
intelligent agents, which may be under the control of different organizations and users. The interaction among
intelligent agents can unlock new economic and social value, just like the interactions among various Internet-
based services was enabled with the advent of the web browser.

There is a need for a standard common protocol that is used by humans to interact with an intelligent agent,
and for intelligent agents to interact with each other. ECMA-430 specification proposes such a protocol, the
Natural Language Interaction Protocol (NLIP).

This Standard describes the binding of NLIP protocol to a base transfer protocol which is using HTTP/HTTPS.




This Ecma Standard was developed by Technical Committee 56 and was adopted by the General
Assembly of December 2025.




ii                                                                                       © Ecma International 2025
COPYRIGHT NOTICE
© 2025 Ecma International
By obtaining and/or copying this work, you (the licensee) agree that you have read, understood, and will
comply with the following terms and conditions.
This document may be copied, published and distributed to others, and certain derivative works of it may
be prepared, copied, published, and distributed, in whole or in part, provided that the above copyright
notice and this Copyright License and Disclaimer are included on all such copies and derivative works.
The only derivative works that are permissible under this Copyright License and Disclaimer are:
(i)   works which incorporate all or portion of this document for the purpose of providing commentary or
      explanation (such as an annotated version of the document),
(ii) works which incorporate all or portion of this document for the purpose of incorporating features that
     provide accessibility,
(iii) translations of this document into languages other than English and into different formats and
(iv) works by making use of this specification in standard conformant products by implementing (e.g. by
     copy and paste wholly or partly) the functionality therein.
However, the content of this document itself may not be modified in any way, including by removing the
copyright notice or references to Ecma International, except as required to translate it into languages
other than English or into a different format.
The official version of an Ecma International document is the English language version on the Ecma
International website. In the event of discrepancies between a translated version and the official version,
the official version shall govern.
The limited permissions granted above are perpetual and will not be revoked by Ecma International or
its successors or assigns.
This document and the information contained herein is provided on an "AS IS" basis and ECMA
INTERNATIONAL DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE ANY
OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A
PARTICULAR PURPOSE.




© Ecma International 2025                                                                                iii
Binding of the Natural Language Interaction Protocol (NLIP)
over HTTP/HTTPS



1      Scope

This Standard defines how the Natural Language Interaction Protocol (NLIP) should be implemented over the
base transfer protocol of HTTP or HTTPS. The exemplar use-cases for NLIP implementation over HTTP or
HTTPS are out of scope of this Standard.


2      Conformance

A conforming implementation must provide and support all types of messages and submessage along with the
semantics defined in the NLIP specification draft, and support them over HTTP or HTTPS.

A conforming production deployment of NLIP must select a security profile defined in ECMA-434 and support
it.


3      Normative references

The following documents are referred to in the text in such a way that some or all of their content constitutes
requirements of this document. For dated references, only the edition cited applies. For undated references, the
latest edition of the referenced document (including any amendments) applies.

ECMA-430, Natural Language Interaction Protocol (NLIP)

ECMA-434, Security Profiles for the Natural Language Interaction Protocol (NLIP)

IETF RFC 2119, Key words for use in RFCs to Indicate Requirement Levels
[https://datatracker.ietf.org/doc/rfc2119]

IETF RFC 7230, Hypertext Transfer Protocol (HTTP/1.1): Message Syntax and Routing
[https://datatracker.ietf.org/doc/rfc7230/]

IETF RFC 7240, Prefer Header for HTTP
[https://datatracker.ietf.org/doc/rfc7240/]

IETF RFC 9113, HTTP/2
[https://datatracker.ietf.org/doc/rfc9113/

IETF RFC 9114, HTTP/3
[https://datatracker.ietf.org/doc/rfc9113/]


4      Terms and definitions

For the purposes of this document, the following terms and definitions apply.

4.1
NLIP
NLIP or Natural Language Interaction Protocol is the protocol defined in ECMA-430.


© Ecma International 2025                                                                                     1
4.2
base transfer protocol
a base transfer protocol is a communication protocol between two computer systems which supports an
encrypted and authenticated transfer of data across those computer systems. In this specification, the base
transfer protocol is http/https.


5       Notational conventions

In this Standard, the following conventions that are consistent with IETF RFC 2119 are used:

•     “Shall” indicates that the item is an absolute requirement of the specification

•     “Should” indicates that there may exist valid reasons in particular circumstances to ignore a particular item,
      but the full implications must be understood and carefully weighed before choosing a different course.

•     “May” indicates that that an item is truly optional. One vendor may choose to include the item because a
      particular marketplace requires it or because the vendor feels that it enhances the product while another
      vendor may omit the same item. An implementation which does not include a particular option shall be
      prepared to interoperate with another implementation which does include the option, though perhaps with
      reduced functionality. In the same vein an implementation which does include a particular option shall be
      prepared to interoperate with another implementation which does not include the option (except, of course,
      for the feature the option provides.)


6       NLIP end point

A conformant implementation of NLIP over HTTP/HTTPS will have the server end-point running on a TCP
Server Port. This end-point would be accessible using a URL defined as https://<server_name>:port/nlip. The
end-point shall support accepting an NLIP message using the POST command of HTTP.

The end-point should use either HTTP/1.1 or HTTP/2 as the base transfer protocol, Implementations may use
HTTP/3 in validated use cases.

6.1       Optional end points

A NLIP end point may also provide an alternate end-point for upload of large binary data. This upload will be
provided at any port different than the port used by NLIP end point. The protocol and extension can be provided
by an NLIP end point to its peer using a control message with structured format.




2                                                                                            © Ecma International 2025
© Ecma International 2025
