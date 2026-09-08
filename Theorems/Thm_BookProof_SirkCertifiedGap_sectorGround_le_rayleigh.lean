-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.sectorGround_le_rayleigh
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap










noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

theorem BookProof.SirkCertifiedGap.sectorGround_le_rayleigh {T : E →ₗ[ℂ] E} {P : E →ₗ[ℂ] E} {s : ℝ}
    (hT : T.IsSymmetric) {x : E} (hx : ‖x‖ = 1) (hmem : x ∈ paritySector P s) :
    sectorGround T P s ≤ rayleigh T x := by sorry
