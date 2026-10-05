-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.cembed_injective
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] :
    Function.Injective (cembed : ℂ → (V →L[ℝ] V)) := (cembed : ℂ →ₐ[ℝ] (V →L[ℝ] V)).toRingHom.injective
