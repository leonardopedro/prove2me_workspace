-- Generated from ChapterYangMillsCertificateSeam.lean — solution of BookProof.YangMillsCertificateSeam.example_checkBounds
import Mathlib
import Definitions.Def_ChapterYangMillsCertificateSeam
open BookProof.YangMillsCertificateSeam



noncomputable section


open BookProof.SirkCertificateReader
open BookProof.SchurGershgorin
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : exampleRecord.checkBounds = true := by

  rw [MatrixBoundRecord.checkBounds]
  norm_num [MatrixBoundRecord.epsQ, MatrixBoundRecord.muQ, MatrixBoundRecord.dminQ,
    MatrixBoundRecord.rmaxQ, exampleRecord, Decimal.toQ]
