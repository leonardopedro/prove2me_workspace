-- Generated from ChapterLorentzRealRep.lean — theorem BookProof.ChapterLorentzRealRep.WHalf_invariant_apply
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterLorentzRealRep


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

theorem BookProof.ChapterLorentzRealRep.WHalf_invariant_apply (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega)
    (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : A ∈ WHalf) :
    castR S * A * castR (cinv S) ∈ WHalf := by sorry
