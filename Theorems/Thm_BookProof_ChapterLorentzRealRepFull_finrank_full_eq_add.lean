-- Generated from ChapterLorentzRealRepFull.lean — theorem BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRepSum
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepFull


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

theorem BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add :
    finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ)
      = finrank ℝ WHalf + finrank ℝ W10 + finrank ℝ WPs + finrank ℝ WTwo := by sorry
