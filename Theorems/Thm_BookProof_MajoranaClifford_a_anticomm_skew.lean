-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.a_anticomm_skew
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.a_anticomm_skew (J : V →ₗ[ℝ] V) (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    a v * a (J v) + a (J v) * a v = 0 := by sorry
