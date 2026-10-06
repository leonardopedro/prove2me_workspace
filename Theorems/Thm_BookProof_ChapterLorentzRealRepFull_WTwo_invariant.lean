-- Generated from ChapterLorentzRealRepFull.lean — theorem BookProof.ChapterLorentzRealRepFull.WTwo_invariant
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRepSum
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterLorentzRealRep
open BookProof.ChapterPinDoubleCover
open BookProof.ChapterLorentzRealRepFull


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

theorem BookProof.ChapterLorentzRealRepFull.WTwo_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WTwo.map (conjL (castR S) (castR (cinv S))) ≤ WTwo := by sorry
