-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.isSelfAdjoint_witness
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) (x : E2) : IsSelfAdjoint (witness M x) := by

  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro u v
  simp only [ContinuousLinearMap.coe_coe, witness_apply, inner_smul_left, inner_smul_right,
    inner_sub_left, inner_sub_right, Complex.conj_ofReal]
  rw [inner_conj_symm]
  ring
