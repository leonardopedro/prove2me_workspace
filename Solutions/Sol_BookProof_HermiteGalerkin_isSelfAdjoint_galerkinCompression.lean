-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.isSelfAdjoint_galerkinCompression
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ F) (m : ℕ) : IsSelfAdjoint (galerkinCompression A b m) := by

  have hP : IsSelfAdjoint (galerkinSpan b m).starProjection :=
    isSelfAdjoint_starProjection _
  change star ((galerkinSpan b m).starProjection * A * (galerkinSpan b m).starProjection)
    = (galerkinSpan b m).starProjection * A * (galerkinSpan b m).starProjection
  rw [star_mul, star_mul, hP.star_eq, hA.star_eq, mul_assoc]
