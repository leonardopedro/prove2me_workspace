-- Generated from ChapterLorentzRealRepDirect.lean — solution of BookProof.ChapterLorentzRealRepDirect.WFam_iSupIndep
import Mathlib
import Definitions.Def_ChapterLorentzRealRepDirect
import Theorems.Thm_BookProof_ChapterLorentzRealRepDirect_WFam_isInternal
open BookProof.ChapterLorentzRealRepDirect



open Matrix Module


open BookProof.ChapterLorentzRealRep BookProof.ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull

set_option maxHeartbeats 1000000 in
theorem solution : iSupIndep WFam := WFam_isInternal.submodule_iSupIndep
