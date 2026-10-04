-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Rcomplex_realCommutant_eq_complex
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.Rcomplex_realCommutant_eq_complex (M : System ℂ V) (hSchur : IsSchurFull M)
    (hNo : NoAntilinearCommutant M) (S : V →L[ℝ] V) :
    RealCommutes M S ↔ ∃ c : ℂ, S = cembed c := by sorry
