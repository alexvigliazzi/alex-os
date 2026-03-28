# ieee.p730.1.1989

> Fonte: `ieee.p730.1.1989.pdf`

                       By Authority Of
         THE UNITED STATES OF AMERICA
              Legally Binding Document
By the Authority Vested By Part 5 of the United States Code § 552(a) and
Part 1 of the Code of Regulations § 51 the attached document has been duly
INCORPORATED BY REFERENCE and shall be considered legally
binding upon all citizens and residents of the United States of America.
HEED THIS NOTICE: Criminal penalties may apply for noncompliance.



                             e
Document Name:         IEEE P730.1: Standard for Software Quality
                       Assurance Plans
CFR Section(s):       7 CFR 1755.522(n)(2)


Standards Body:       Institute of Electrical and Electronics Engineers




                                         Official Incorporator:
                                         THE EXECUTIVE DIRECTOR
                                         OFFICE OF THE FEDERAL REGISTER
                                         WASHINGTON, D.C.
                                                                                          IEEE St.d 730.1-1989
                                                                                          (Revision of ANSIJIEEE Std 730-1984)·




IEEE Standard for Software
Qual ity Assu ranee Plans


                 .                                                   Circuits and Devices


     I

                                                                     Communications Technology

         Computer
         Sponsored by the
         Technical Committee on Software Engineering of the
         IEEE Computer Society

                                                                     Electromagnetics and.
     I
                                                                     Radiation


                                                                     Energy and Power



                                                                     Industrial Applications


                                                                     Signals and
                                                                     Applications




         Published by the Institute of Electrical and Electronics Engineers, Inc., 345 East 47th S treet, New York, NY 10017, USA.

     October 10,1989                                                                                                     SH12849

c.
                                                                    P730.1-1989
                                                                    (Revision of ANSVIEEE
                                                                    Std 730-1984)




       IEEE Standard for
Software Quality Assurance Plans




                               Sponsor
     Technical Committee on Software Engineering
                       of the
                IEEE Computer Society


                    Approved August 17, 1989
                    IEEE Standards Board




                          © Copyright 1989 by

The Institute of Electrical and Electronics Engineers, Inc
     345 East 47th Street, New York, NY 10017, USA

       No part of this publication may be reproduced in any form,
            in an electronic retrieval system or otherwise,
         without the prior written permission of the publisher.
                                      IEEE Standards documents are developed within the Technical
                                   Committees of the IEEE Societies and the Standards Coordinating
                                   Committees of the IEEE Standards Board. Members of the committees
                                   serve voluntarily and without compensation. They are not necessar-
                                   ily members of the Institute. The standards developed within IEEE
                                   represent a consensus of the broad expertise on the subject within the
                                   Institute as well as those activities outside of IEEE which have
                                   expressed an interest in participating in the development of the
                                   standard.
                                     Use of an IEEE Standard is wholly voluntary. The existence of an
                                   IEEE Standard does not imply that there are no other ways to produce,
                                   test, measure, purchase, market, or provide other goods and services
                                   related to the scope of the IEEE Standard. Furthermore, the viewpoint
                                   expressed at the time a standard is approved and issued is subject to
                                   change brought about through developments in the state of the art and
                                   comments received from users of the standard. Every IEEE Standard
                  <g:.         'I: is subjected to review at least every five years for revision or reaffir-
                     '1'.    ,., mation. When a document is more than five years old, and has not


C'! II'
          ..   ".. '," been reaffirmed, it is reasonable to conclude that its contents, al-
                  111', though still of some value, do not wholly reflect the present state of the
                          ,~;\, aft. Users are cautioned to check to determine that they have the latest
                          1'j~\~J.ition of any IEEE Standard.
                               \l~ eomments for revision of IEEE Standards are welcome from any
                ~              i~n1terested party, regardless of membership affiliation with IEEE.
                                   Suggestions for changes in documents should be in the form of a pro-
                                   posed change of text, together with appropriate supporting comments.
                                      Interpretations: Occasionally questions may arise regarding the
                                   meaning of portions of standards as they relate to specific applica-
                                   tions. When the need for interpretations is brought to the attention of
                                   IEEE, the Institute will initiate action to prepare appropriate re-
                                   sponses. Since IEEE Standards represent a consensus of all con-
                                   cerned interests, it is important to ensure that any interpretation has
                                   also received the concurrence of a balance of interests. For this reason
                                   IEEE and the members of its technical committees are not able to
                                   provide an instant response to interpretation requests except in those
                                   cases where the matter has previously received formal consideration.
                                      Comments on standards and requests for interpretations
                                   addressed to:
                                                          Secretary, IEEE Standards Board
                                                          445 Hoes Lane
                                                          P.O. Box 1331
                                                          Piscataway, NJ 08855-1331
                                                          USA


                            IEEE Standards documents are adopted by the Institute of Electrical
                          and Electronics Engineers without regard to whether their adoption
                          may involve patents on articles, materials, or processes. Such adop-
                          tion does not assume any liability to any patent owner, nor does it
                          assume any obligation whatever to parties adopting the standards
                          documents.
                                                        Foreword
 (This Foreword is not a part of IEEE Std 730.1-1989, IEEE Standard for Software Quality Assurance Plans.)

   This standard assists in the preparation and content of Software Quality Assurance Plans and
provides a standard against which such plans can be prepared and assessed. It is directed toward
the development and maintenance of critical software-that is, where failure could impact safety
or cause large financial or social losses.
   The readers of this document are referred to ANSI/IEEE Std 983-1986, IEEE Guide for Software
Quality Assurance Planning, for recommended approaches to good software quality assurance
practices in support of this standard. While ANSI/IEEE Std 983-1986 specifically refers to
ANSI/IEEE Std 730-1984, almost all of its content applies directly to this revision.
   In this standard, firmware is considered to be software and is to be treated as such.
   Footnotes are not part of the standard.
   There are three groups to whom this standard applies: the user, the developer, and the public.
   (1) The user, who may be another element of the same organization developing the software, has
a need for the product. Further, the user needs the product to meet the requirements identified in the
specification. The user thus cannot afford a "hands-off' attitude toward the developer and rely
solely on a test to be executed at the end of the software development time period. If the product
should fail, not only does the same need still exist, but also a portion of the development time has
been lost. Therefore, the user needs to obtain a reasonable degree of confidence that the product is
in the process of acquiring required attributes during software development.
   (2) The developer needs an established standard against which to plan and to be measured. It is
unreasonable to expect a complete reorientation from project to project. Not only is it not cost effec-
tive, but, unless there exists a stable framework on which to base changes, improvement cannot be
made.
   (3) The public may be affected by the users' use of the product. These users include, for example,
depositors at a bank or passengers using a reservation system. Users have requirements, such as
legal rights, which preclude haphazard development of software. At some later date, the user and
the developer may be required to show that they acted in a reasonable and prudent professional
manner to ensure that required software attributes were acquired.
   This standard was prepared by the Software Engineering Standards Subcommittee of the
Software Engineering Technical Committee of the IEEE Computer Society. It was initially
approved by the IEEE Standards Board for "trial use" in December of 1979, with a subsequent "full
use" approval in September of 1981, and a revision approved on June 14, 1984.
   The Working Group consisted of the following members:
                 F. Buckley, Chairperson                 c. White-Partain, Vice-Chairperson
                                                Executive Committee:
         S.Ali                                R. Fordham                           C.Modell
         W. Barret                            M. Hein                              S. Norman
         R. Braun                             R. Kosinski                          S. Trauth
         W. Eventotf                          E. Maginnius                         A. Tegtmeier
                                              L. Marquis
                                                        Members:
         J. Agrawal                           S.JonfS                              A. Serna, Jr.
         M. Ben-Menachem                      H. Kaplan                            R. Shillato
         J. Case                              M. Karasik                           T. Smith
         J. Chihorek                          R. Kenneavy                          R. Stanton
         M. Dewalt                            T. Kurihara                          R. Stenglein
         D.Doty                               B. Livson                            A. Sullivan
         R. Euler                             A. Miller                            O. Tanir
         R. Evans                             R. Martin                            E. Testa
         J.Ewin                               P. Pfister                           L. To
         M. Fitch                             R. Poston                            G. Tucker
         M. Ghiassi                           F. Rienstra                          H. van doornum
         J.Gilmore                            J. Roberts                           C. Von Schantz
         B. Gundaker                          F. Rose                              D. Wallace
         J. Horch                             W. Schultzer                         P. Willis
         R. Ivy                               W. Schunk                            P. Wolfgang
                                              C.Seddin
 Special Representatives to the Software Engineering Standards Subcommittee for this action
were as follows:

  Nuclear Power Engineering Committee/Power Engineering Society: N. Farr

  Quality Assurance Management Committee of the IEEE Communications Society: R. Mosher

  Canadian Standards Association: B. Dyczkowsky

  Data Processing Manufacturers' Association: W. Perry

  At the time that the IEEE Standards Board approved this revision, the Software Engineering
Standards Subcommittee, which was the balloting committee that approved this document for
submission to the IEEE Standards Board, had the following membership:

                                  John Horch, Chairman
        W. Arfvidson               J. Gilmore                  P. Peterson
        C. Arnold                  S. Gloss-Soler              J. Phippen
        R. Aurbach                 J. Glynn                    J.Pope
        E. Baker                   J. Gonzalez-Sanz            R. Poston
        B. Banerjee                V. Guarnera                 I. Pyle
        B. Beizer                  D. Gustafson                G. Ray
        M. Ben·Menachem            J. Guttman                  M. Razy
        R. Berlack                 B. Harbort                  J. Reddan
        B. Bina                    C. Hay                      S. Redwine
        M. Blackledge              J. Hillawi                  J. Roberts
        R. Blasewitz               J. Horch                    R. Roman
        R. Both                    P. Hung                     R. Roth
        K. Briggs                  D. Johnson III              F. Ruhlman
        A. Brown                   J. Kalasky                  S. Schach
        W. Bryan                   L. Kaleda                   H. Schaefer
        F. Buckley                 M. Karasik                  N. Schneidewind
        C. Carpenter               R. Karcich                  W. Schnoege
        J. Case                    O.Kato                      H. Schock
        T. Chow                    P. Klopfenstein             D. Schultz
        W. Chung                   S. Koenig                   G. Schumacher
        F. Coallier                R. Kosinski                 L. Seagren
        G. Copeland                T. Kurihara                 L. Shafer
        P. Daggett                 L. Lam                      R. Shillato
        M. Daniels                 J.Lane                      D. Siefert
        T. Daughtrey               R. Lane                     I. Sjors
        K. DeJong                  G. Larsen                   A. Sorkowitz
        D. Deluna                  F. Lim                      T. Stalhane
        C. Dencker                 K. Linberg                  N. Stewart
        P. Denny                   B. Lindberg                 W. Strigel
        B. Derganc                 B. Livson                   R. Thayer
        A. Dolinsky                H. Mains                    P. Thompson
        R. Dwyer                   H. Malec                    G. Tice
        L. Egan                    J. Malsbury                 T. Tillmanns
        M. Egeland                 L. Marquis                  E. Tomlin
        S. Eisen                   P. Marriott                 S. Trauth
        R. Erickson                R. Martin                   L. Tripp
        R. Euler                   T. Matsubara                M. Uchida
        C. Evans                   I. Mazza                    D. Ulery
        J. Fendrich                J. Mersky                   H. Verne
        A. Foley                   C. Modell                   C. Von Schantz
        R. Fordham                 H. Nagano                   D. Wallace
        J. Forman                  S. Najafi                   J. Walter
        J. Franklin                G. Neidhart                 R. Weger
        I. Fuentes                 D. Nickle                   P. Willis
        A. Geraci                  J.O'Day                     P. Wolfgang
        Y. Gershkovitch            M. Olson                    T. Worthington
        D. Geyer                   W. Osbourne                 N. Yopconka
        E. Gibbs                   T. Parrish                  P. Zoll
                                   M. Perkins
 When the IEEE Standards Board approved this standard on August 17, 1989, it had the following
membership:

  Dennis Bodson, Chairman                          Marco W. Migliaro, Vice Chairman
                             Andrew G. Salem, Secretary
    Arthur A. Blaisdell          Kenneth D. Hendrix              John E. May, Jr.
    Fletcher J. Buckley          Theodore W. Hissey, Jr.         Lawrence V. McCall
    Allen L. Clapp               John W. Horch                   L. Bruce McClung
    James M. Daly                David W. Hutchins               Donald T. Michael*
    Stephen R. Dillon            Frank D. Kirschner              Richard E. Mosher
    Donald C. Fleckenstein       Frank C. Kitzantides            Stig Nilsson
    Eugene P. Fogarty            Joseph L. Koepfinger*           L. John Rankine
    Jay Forster·                 Edward Lohse                    Gary S. Robinson
    Thomas L. Hannan                                             Donald W. Zipse

*Member Emeritus
                                                   Contents
SECTION                                                                                                      PAGE

1.   Scope and References .................................................................................... 7
     1.1 Scope ................................................................................................. 7
     1.2 References .......................................................................................... 7
2.   Definitions and Acronyms ............................................................................. 8
     2.1 Definitions .......................................................................................... 8
     2.2 Acronyms ........................................................................................... 8
3.   Software Quality Assurance Plan ..................................................................... 9
     3.1 Purpose (Section 1 of the SQAP) .............................................................. 9
     3.2 Reference Documents (Section 2 of the SQAP) .................................................. 9
     3.3 Management (Section 3 of the SQAP) ............................................................ 9
          3.3.1 Organization ................................................................................ 9
          3.3.2 Tasks ......................................................................................... 9
          3.3.3 Responsibilities ............................................................................. 9
     3.4 Documentation (Section 4 of the SQAP) ...................................................... 9
          3.4.1 Purpose ............................................................. , ......................... 9
          3.4.2 Minimum Documentation Requirements ............................................ , .10
                3.4.2.1 Software Requirements Specification (SRS) ................................. 10
                3.4.2.2 Software Design Description (SDD) ........................................... 10
                3.4.2.3 Software Verification and Validation Plan (SVVP) ........................ 10
                3.4.2.4 Software Verification and Validation Report (SVVR) ...................... 10
                3.4.2.5 User Documentation ............................................................ 10
                3.4.2.6 Software Configuration Management Plan ............................... 10
          3.4.3 Other ......................................................................................... 10
     3.5 Standards, Practices, Conventions and Metrics (Section 5 of the SQAP) ................... 10
          3.5.1 Purpose ...................................................................................... 10
          3.5.2 Content ...................................................................................... 10
     3.6 Reviews and Audits (Section 6 of the SQAP) ....................................... " .......... 10
          3.6.1 Purpose ...................................................................................... 10
          3.6.2 Minimum Requirements ................................................................. 11
                3.6.2.1 Software Requirements Review (SRR) ....................................... 11
                3.6.2.2 Preliminary Design Review (PDR) .......................................... l1
                3.6.2.3 Critical Design Review (CDR) .............................................. l1
                3.6.2.4 Software Verification and Validation Plan Review (SVVPR) ............ 11
                3.6.2.5 Functional Audit ................................................................ 11
                3.6.2.6 Physical Audit ................................................................... 11
                3.6.2.7 In-Process Audits ............................................................... 11
                3.6.2.8 Managerial Reviews ........................................................... 11
                3.6.2.9 Software Configuration Management Plan Review (SCMPR) ............ l1
                3.6.2.10 Post Mortem Review ........................................................... 11
          3.6.3 Other ......................................................................................... 11
     3.7 Test (Section 7 of the SQAP) ...................................................................... 11
     3.8 Problem Reporting and Corrective Action (Section 8 of the SQAP) .......................... 11
     3.9 Tools, Techniques, and Methodologies (Section 9 of the SQAP) ............................. l1
     3.10 Code Control (Section 10 of the SQAP) ..................................................... l1
     3.11 Media Control (Section 11 of the SQAP) ................................................... 12
     3.12 Supplier Control (Section 12 of the SQAP) ...................................................... 12
     3.13 Records Collection, Maintenance, and Retention (Section 13 of the SQAP) ................ 12
     3.14 Training (Section 14 of the SQAP) .............................................................. 12
     3.15 Risk Management (Section 15 of the SQAP) ................................................... 12
                          IEEE Standard for
                   Software Quality Assurance Plans

           1. Scope and References                            [2] ANSVIEEE Std 603-1980, IEEE Standard
                                                              Criteria for Safety Systems for Nuclear Power
1.1 Scope. The purpose of this standard is to                 Generating Stations.
provide uniform, minimum acceptable re-
quirements for preparation and content of                     [3] ANSI/IEEE Std 729-1983, IEEE Standard
Software Quality Assurance Plans (SQAPs).                     Glossary of Software Engineering Termi-
  In considering adoption of this standard,                   nology.2
regulatory bodies should be aware that specific
application of this standard may already be                   [4] ANSVIEEE Std 828-1983, IEEE Standard for
covered by one or more IEEE or ANSI stan-                     Software Configuration Management Plans.
dards documents relating to quality assur-
ance, definitions, or other matters. It is not the            [5] ANSVIEEE Std 829-1983, IEEE Standard for
purpose of this document to supersede, revise or              Software Test Documentation.
amend existing standards directed to specific
industries or applications.                                   [6] ANSVIEEE Std 830-1984, IEEE Guide for
  This standard applies to the development                    Software Requirements Specifications.
and maintenance of critical software. For
non-critical software, or for software already                [7] IEEE Std 982.1-1988, IEEE Standard Dictio-
developed, a subset of the requirements of this               nary of Measures to Produce Reliable Soft-
standard may be applied.                                      ware.
  The existence of this standard should not be
construed to prohibit additional content in a                 [8] IEEE Std 982.2-1988, IEEE Guide for the Use
SQAP. An assessment should be made for the                    of IEEE Standard Dictionary of Measures to
specific software item to assure adequacy of                  Produce Reliable Software.
coverage. Where this standard is invoked for
an organization or project engaged in produc-                 [9] ANSVIEEE Std 983-1986, IEEE Guide for
ing several software items, the applicability of              Software Quality Assurance Planning. (This
the standard should be specified for each of the              is being redesignated to 730.2.)
software items.
                                                              [10] ANSI/IEEE Std 990-1987, IEEE Recom-
1.2 References. The standards listed below                    mended Practice for Ada as a Program De-
should be used for further information. In                    sign Language.
using these references, the latest revisions
should be obtained. Compliance with this                      [11] ANSI/IEEE Std 1002-1987, IEEE Standard
standard does not require nor imply compli··                  Taxonomy of Software Engineering Stan-
ance with any of those listed.                                dards.

[1] ANSVASME NQA-1-1983, Quality Assur-                       [12] ANSVIEEE Std 1008-1987, IEEE Standard
ance Program Requirements for Nuclear                         for Software Unit Testing.
Facilities. l

  lANSVASME publications are available from the Sales            2ANSVIEEE publications may be obtained from the
Department, American National Standards Institute, 1430       IEEE Service Center, 445 Hoes Lane, P.O. Box 1331,
Broadway, New York, NY 10018 or from the ASME Order           Piscataway, NJ 08855·1331 or from the Sales Department,
Department, 22 Law Drive, P.O. Box 2300, Fairfield, N,T       American National Standards Institute, 1430 Broadway,
07007·2300.                                                   New York, NY 10018.



                                                          7
IEEE
Std 730.1-1989                                                                     IEEE STANDARD FOR SOFTWARE

[13] ANSVIEEE Std 1012-1986, IEEE Standard                   decision point metric. The result of dividing
for Software Verification and Validation                     the total number of modules in which every
Plans.                                                       decision point has had (1) an valid conditions,
                                                             and (2) at least one invalid condition, cor-
[14] ANSI/IEEE Std 1016-1987, IEEE Recom-                    rectly processed, divided by the total number of
mended Practice for Software Design De-                      modules. 5
scri ptions.
                                                             domain metric. The result of dividing the total
                                                             number of modules in which one valid sample
[15] IEEE Std 1028-1988, IEEE Standard for
                                                             and one invalid sample of every class of input
Software Reviews and Audits.
                                                             data items (external messages, operator in-
                                                             puts, and local data) have been correctly pro-
[16] ANSI/IEEE Std 1033-1985, IEEE Recom-
                                                             cessed, by the total number of modules. 6
mended Practice for Application of IEEE Std
828 to Nuclear Power Generating Stations.                    error message metric. The result of dividing
                                                             the total number of error messages that
[17] ANSVIEEE Std 1042-1987, IEEE Guide to                   have been formally demonstrated, by the total
Software Configuration Management.                           number of error messages.
                                                             quality assurance. A planned and systematic
[18] ANSI/IEEE Std 1058.1-1988, IEEE Stan-
                                                             pattern of all actions necessary to provide ade-
dard for Software Project Management Plans.
                                                             quate confidence that the item or product con-
                                                             forms to established technical requirements.
[19] ANSVIEEE Std 1063-1988, IEEE Standard
for Software User Documentation.                             requirements demonstration metric. The re-
                                                             sult of dividing the total number of separately-
[20] ANSVIEEE/ANS 7-4.3.2-1982, Application                  identified requirements in the software re-
Criteria for Programmable Digital Computer                   quirements specification (SRS) that have
Systems in Safety Systems of Nuclear Power                   been successfully demonstrated by the total
Generating Stations.                                         number of separately-identified requirements
                                                             in the SRS.

         2. Definitions and Acronyms                         2.2 Acronyms. The following alphabetical
                                                             contractions appear within the text of this
2.1 Definitions. The definitions listed below                standard:
establish meaning in the context of this                     CDR-critical design review
standard. Other definitions can be found in                  PDR-preliminary design review
ANSVIEEE Std 729-1983, IEEE Standard Glos-                   SCMP-software configuration management
sary of Software Engineering Terminology,                       plan
or latest revision thereof[3].3 For the purpose of           SCMPR-software configuration manage-
this standard, the term "software" includes                     ment plan review
firmware, documentation, data, and execution                 SDD-software design description
control statements (eg, command files, job                   SQA-software quality assurance
control language, etc).                                      SQAP-software quality assurance plan
                                                             SRR-software requirements review
branch metric. The result of dividing the total
                                                             SRS-software requirements specification
number of modules in which every branch has
                                                             SVVP-software verification and validation
been executed at least once by the total number
                                                                 plan
of modules. 4
                                                             SVVPR-software verification and validation
critical software. Software whose failure                        plan review
would impact safety or cause large financial                 SVVR-software verification and validation
or social losses.                                                report
                                                             UDR-user documentation review
   3The numbers in brackets correspond to those of the
references listed in 1.2.
   4This definition assumes that the modules are               5 See footnote 4.
essentially the same size.                                     6 See footnote 4.




                                                         8
                                                                                                                 IEEE
QUALITY ASSURANCE PLANS                                                                                 Std 730.1-1989

    3. Software Quality Assurance Plan                          3.1 Purpose (Section 1 of the SQAP). This
                                                                section shall delineate the specific purpose and
  The Software Quality Assurance Plan shall                     scope of the particular SQAP. It shall list the
include the sections listed below to be in com-                 name(s) of the software items covered by the
pliance with this standard. The sections                        SQAP and the intended use of the software. It
should be ordered in the described sequence. If                 shall state the portion of the software life cycle
the sections are not ordered in the described                   covered by the SQAP for each software item
sequence, then a table shall be provided at the                 specified.
end of the SQAP that provides a cross-refer-
ence from the lowest numbered subsection of                     3.2 Reference Documents (Section 2 of the
this standard to that portion of the SQAP where                 SQAP). This section shall provide a complete
that material is provided. If there is no infor-                list of documents referenced elsewhere in the
mation pertinent to a section, the following                    text ofthe SQAP.
shall appear below the section heading, "This
section is not applicable to this plan," together               3.3 Management (Section 3 of the SQAP). This
with the appropriate reasons for the exclusion.                 section shall describe organization, tasks,
(1)   Purpose                                                   and responsibilities. 8
(2)   Reference documents                                         3.3.1 Organization. This paragraph shall
(3)   Management                                                depict the organizational structure that influ-
(4)   Documentation                                             ences and controls the quality of the software.
(5)   Standards, practices, conventions, and                    This shall include a description of each major
      metrics                                                   element of the organization together with the
(6) Reviews and audits                                          delegated responsibilities. Organizational de-
(7) Test                                                        pendence or independence of the elements
(8) Problem reporting and corrective action                     responsible for SQA from those responsible for
(9) Tools, techniques, and methodologies                        software development and use shall be clearly
(10) Code control                                               described or depicted.
(11) Media control                                                3.3.2 Tasks. This paragraph shall describe
(12) Supplier control                                           (a) that portion of the software life cycle cov-
(13) Records collection, maintenance, and                       ered by the SQAP, (b) the tasks to be performed
      retention                                                 with special emphasis on software quality
(14) Training                                                   assurance activities, and (c) the relationships
(15) Risk management                                            between these tasks and the planned major
  Additional sections may be added as re-                       check-points. The sequence of the tasks shall
quired.                                                         be indicated.
  Some of the material may appear in other                        3.3.3 Responsibilities. This paragraph shall
documents. If so, then reference to these docu-                 identify the specific organizational elements
ments should be made in the body ofthe SQAP.                    responsible for each task.
In any case, the contents of each section of the
plan shall be specified either directly or by                   3.4 Documentation (Section 4 of the SQAP)
reference to another document.                                    3.4.1 Purpose. This section shall perform the
  The SQAP shall be approved by the chief op-                   following functions:
erating officer of each unit of the organization                (1) Identify the documentation governing the
having responsibilities defined within this                         development, verification and validation,
SQAP or their designated representatives.                           use, and maintenance of the software.
  Details for each section of the SQAP are                      (2) State how the documents are to be checked
described in 3.1 through 3.15 of this standard. 7                   for adequacy. This shall include the crite-
                                                                    ria and the identification of the review or
   7 Guidance in the use of this standard can be found in           audit by which the adequacy of each docu-
ANSIlIEEE Std 983-1986 [9]. For an expansion of the
quality and equipment qualification requirements of                 ment shall be confirmed, with reference to
IEEE Std 603-1980, IEEE Standard Criteria for Safety                Section 6 of the SQAP.
Systems for Nuclear Power Generating Stations [2]; to
encompass software design, software implementation,
and computer systems validation, see ANSIlIEEE/ANS 7-             8See ANSIlIEEE Std 1002-1987 [11] and ANSIlIEEE Sld
4.3.2-1982 [20].                                                1058.1-1988 [18].



                                                            9
IEEE
Std 730.1-1989                                                                    IEEE STANDARD FOR SOFTWARE

   3.4.2 Minimum Documentation Require-                        itations, and other activities or items neces-
ments. To ensure that the implementation                       sary for successful execution of the software.
of the software satisfies requirements, the                    All error messages shall be identified and
following documentation is required as a                       corrective actions described. A method of de-
minimum:                                                       scribing user-identified errors or problems to
      3.4.2.1 Software Requirements Specifica-                 the developer or the owner of the software shall
tion (SRS). The SRS shall clearly and pre-                     be described. (Embedded software that has no
cisely describe each of the essential re-                      direct user interaction has no need for user
quirements (functions, performances, design                    documentation and is therefore exempted from
constraints, and attributes) of the software and               this requirement.)12
the external interfaces. Each requirement                           3.4.2.6 Software Configuration Manage-
shall be defined such that its achievement is                  ment Plan (SCMP). The SCMP shall docu-
capable of being objectively verified and                      ment methods to be used for identifying soft-
validated by a prescribed method; for ex-                      ware items, controlling and implementing
ample, inspection, analysis, demonstration,                    changes, and recording and reporting change
or test. 9                                                     implementation status. 13
      3.4.2.2 Software Design Description                         3.4.3 Other. Other documentation may
(SDD). The SDD shall depict how the software                   include the following:
will be structured to satisfy the requirements                 (1) Software Development Plan
in the SRS. The SDD shall describe the compo-                  (2) Standards and Procedures Manual
nents and subcomponents of the software                        (3) Software Project Management Plan
design, including data bases and internal                      (4) Software Maintenance Manual.
interfaces. The SDD shall be prepared first
as the Preliminary SDD (also referred to                       3.5 Standards, Practices, Conventions and
as the Top-Level SDD) and shall be sub-                        Metrics (Section 5 of the SQAP)
sequently expanded to produce the Detailed                       3.5.1 Purpose. This section shall:
SDD.lO                                                         (1) Identify the standards, practices, conven-
      3.4.2.3 Software Verification and Valida-                    tions and metrics to be applied.
tion Plan (SVVP). The SVVP shall identify                      (2) State how compliance with these items is to
and describe the methods (for example, in-                         be monitored and assured.
spection, analysis, demonstration, or test) to be                3.5.2 Content. The subjects covered shall
used:l1                                                        include the basic technical, design, and
(1) To verify that (a) the requirements in                     programming activities involved, such as
     the SRS have been approved by an appro-                   documentation, variable and module naming,
     priate authority, (b) the requirements in                 programming, inspection, and testing. As a
     the SRS are implemented in the design                     minimum, the following information shall be
     expressed in the SDD; and (c) the design                  provided: 14
     expressed in the SDD is implemented in                    (1) Documentation standards
     the code.                                                 (2) Logic structure standards
(2) To validate that the code, when executed,                  (3) Coding standards
     complies with the requirements expressed                  (4) Commentary standards
     in the SRS.                                               (5) Testing standards and practices
      3.4.2.4 Software Verification and Valida-                (6) Selected software quality assurance prod-
tion Report (SVVR). The SVVR shall de-                             uct and process metrics such as:
scribe the results of the execution of the                         (a) Branch metric
SVVP.                                                              (b) Decision point metric
      3.4.2.5 User Documentation. User docu-                       (c) Domain metric
mentation (eg, manual, guide, etc) shall spec-                     (d) Error message metric
ify and describe the required data and control                     (e) Requirements demonstration metric
inputs, input sequences, options, program lim-
                                                                 I2See ANSIlIEEE Std 1063-1988 [19].
  9See ANSIlIEEE Std 830-1984 [6].                               I3See ANSIlIEEE Std 828-1983 [4] and ANSIlIEEE Std
  I°See ANSIlIEEE Std 1016-1987 [14].                          1042-1987 [17]. See also ANSIlIEEE Std 1033-1985 [16].
  llSee ANSIlIEEE Std 829-1983 [5], ANSIJIEEE Std 1008-          I4See ANSIlIEEE Std 990-1987 [10], ANSIlIEEE Std 982.1-
1987 [12], andANSIlIEEE Std 1012-1986 [13].                    1988 [7] and ANSIlIEEE Std 982.2-1988 [8].



                                                          10
                                                                                                          IEEE
QUALITY ASSURANCE PLANS                                                                          Std 730.1-1989

3.6 Reviews and Audits (Section 6 of the SQAP)           identified in the SQAP. These reviews shall be
  3.6.1 Purpose. This section shall: I5                  held by an organizational element indepen-
(1) Define the technical and managerial                  dent of the unit being reviewed, or by a quali-
     reviews and audits to be conducted.                 fied third party. This review may require
(2) State how the reviews and audits are to be           additional changes in the SQAP itself.
     accomplished.                                            3.6.2.9 Software Configuration Manage-
(3) State what further actions are required              ment Plan Review (SCMPR). The SCMPR is
     and how they are to be implemented and              held to evaluate the adequacy and complete-
     verified.                                           ness of the configuration management meth-
   3.6.2 Minimum Requirements. As a mini-                ods defined in the SCMP.
mum, the following reviews and audits shall                   3.6.2.10 Post Mortem Review. This review
be conducted:                                            is held at the conclusion of the project to assess
     3.6.2.1 Software Requirements Review                the development activities implemented on
(SRR). The SRR is held to ensure the adequacy            that project and to provide recommendations
ofthe requirements stated in the SRS.                    for appropriate actions.
     3.6.2.2 Preliminary Design Review                      3.6.3 Other. Other reviews and audits may
(PDR). The PDR (alsoknown as top-level de-               include the user documentation review
sign review) is held to evaluate the technical ad-       (UDR). This review is held to evaluate the
equacy of the preliminary design (also known             adequacy (eg, completeness, clarity, correct-
as top-level design) ofthe software as depicted in       ness, and usability) of user documentation.
the preliminary software design description.
      3.6.2.3 Critical Design Review (CDR).              3.7 Test (Section 7 of the SQAP). This section
The CDR (also known as detailed design                   shall identify all the tests not included in the
review) is held to determine the acceptability           SVVP for the software covered by the SQAP
of the detailed software designs as depicted in          and shall state the methods to be used. I6
the detailed software design description in
satisfying the requirements of the SRS.                  3.8 Problem Reponing and Corrective Action
      3.6.2.4 Software Verification and Valida-          (Section 8 of the SQAP). This section shall:
tion Plan Review (SVVPR). The SVVPR is                   (1) Describe the practices and procedures to be
held to evaluate the adequacy and complete-                  follo.w.eJl,.
                                                                       '::!1J
                                                                  _\".",,;fi
                                                                              for reporting, tracking, and re-
ness of the verificatioI}, ~,ll:~tV~t.jon methc /            solving;~oblems identified in both soft-
ods defined in the S~R .•"""'~' .....•.                      wareitems~nd the software development
      3.6.2.5 Functiotr~AJti"mr~ audit is held               and maintenance process.
prior to the software delivery to verifY that all re-    (2) State the specific organizational responsi-
quirements specified in the SRS have been met.               bilities concerned with their implemen-
      3.6.2.6 Physical Audit. This audit is held             tation.
to verifY that the software and its documenta-
tion are internally consistent and are ready             3.9 Tools, Techniques, and Methodologies
for delivery.                                            (Section 9 of the SQAP). This section shall
      3.6.2.7 In-Process Audits. In-process              identifY the special software tools, techniques,
audits of a sample of the design are held to             and methodologies that support SQA, state their
verify consistency of the design, including:             purposes, and describe their use.
(1) Code versus design documentation
(2) Interface specifications (hardware and               3.10 Code Control (Section 10 of the SQAP).
     software)                                           This section shall define the methods and
(3) Design implementations versus func-                  facilities used to maintain, store, secure and
     tional requirements                                 document controlled versions of the identified
(4) Functional requirements versus test de-              software during all phases of the software life
     scriptions                                          cycle. This may be implemented in conjunc-
      3.6.2.8 Managerial Reviews. Managerial             tion with a computer program library. This
reviews are held periodically to assess the              may be provided as a part of the SCMP.
execution of all of the actions and the items
                                                           I 6See ANSIlIEEE Std 829-1983 [5] and ANSIlIEEE Std
  ISSee IEEE Std 1028-1988 [15].                         1008-1987 [12].



                                                    11
IEEE
Std 730.1-1989

If so, an appropriate reference shall be made              software items covered by the SQAP. For soft-
thereto.                                                   ware that is to be developed, the supplier shall
                                                           be required to prepare and implement a SQAP
3.11 Media Control (Section 11 of the SQAP).               in accordance with this standard. This section
This section shall state the methods and                   shall also state the methods to be employed to
facilities to be used to (a) identify the media for        assure that the developers comply with the
each computer product and the documentation                requirements of this standard.
required to store the media, including the copy
and restore process, and (b) protect computer              3.13 Records Collection, Maintenance, and
program physical media from unauthorized                   Retention (Section 13 of the SQAP). This sec-
access or inadvertent damage or degradation                tion shall identify the SQA documentation to
during all phases of the software life cycle.              be retained, shall state the methods and facili-
This may be provided as a part of the SCMP. If             ties to be used to assemble, safeguard, and
so, an appropriate reference shall be made                 maintain this documentation, and shall des-
thereto.                                                   ignate the retention period.

3.12 Supplier Control (Section 12 of the SQAP).            3.14 Training (Section 14 of the SQAP). This
This section shall state the provisions for as-            section shall identify the training activities
suring that software provided by suppliers                 necessary to meet the needs of the SQAP.
meets established requirements. In addition,
this section shall state the methods that will             3.15 Risk Management (Section 15 of the
be used to assure that the software supplier               SQAP). This section shall specify the methods
receives adequate and complete requirements.               and procedures employed to identify, assess,
For previously-developed software, this sec-               monitor, and control areas of risk arising
tion shall state the methods to be used to assure          during the portion of the software life cycle
the suitability of the product for use with the            covered by the SQAP.




                                                      12
