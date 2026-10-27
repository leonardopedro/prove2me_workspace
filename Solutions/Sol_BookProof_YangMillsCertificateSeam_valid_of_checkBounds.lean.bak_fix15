-- Generated from ChapterYangMillsCertificateSeam.lean — solution of BookProof.YangMillsCertificateSeam.valid_of_checkBounds
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

set_option maxHeartbeats 1000000 in
theorem solution {c : MatrixBoundRecord} (h : c.checkBounds = true) : c.Valid := by

  rw [MatrixBoundRecord.checkBounds, Bool.and_eq_true, Bool.and_eq_true] at h
  exact ⟨by simpa using h.1.1, by simpa using h.1.2, by simpa using h.2⟩
