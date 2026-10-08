-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cplxify_commutes
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.cplxify_commutes {M : System ℂ V} {T : V →L[ℝ] V}
    (hT : ∀ x, T (Complex.I • x) = Complex.I • T x) (hTc : RealCommutes M T) :
    M.Commutes (cplxify T hT) := by sorry
