-- Generated from ChapterLorentzRealRep.lean — theorem BookProof.ChapterLorentzRealRep.W10_invariant
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterPinDoubleCover
open BookProof.ChapterLorentzRealRep


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

theorem BookProof.ChapterLorentzRealRep.W10_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    W10.map (conjL (castR S) (castR (cinv S))) ≤ W10 := by sorry
