-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.shiftCol_opCol
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockSecondQuantization_opCol_apply
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) (mu : ℝ) :
    shiftCol (opCol b A) mu = opCol b (A - ((mu : ℝ) : ℂ) • LinearMap.id) := by

  funext k
  refine Finsupp.ext fun j => ?_
  have hid : opCol b (((mu : ℝ) : ℂ) • LinearMap.id) k j
      = ((mu : ℝ) : ℂ) * (if j = k then (1 : ℂ) else 0) := by
    rw [opCol_apply]
    simp only [LinearMap.smul_apply, Submodule.coe_smul, inner_smul_right, LinearMap.id_apply]
    simpa using congrArg (fun z : ℂ => ((mu : ℝ) : ℂ) * z)
      (orthonormal_iff_ite.mp b.orthonormal j k)
  have hsub : opCol b (A - ((mu : ℝ) : ℂ) • LinearMap.id) k j
      = opCol b A k j - opCol b (((mu : ℝ) : ℂ) • LinearMap.id) k j := by
    rw [opCol_apply, opCol_apply, opCol_apply]
    simp only [LinearMap.sub_apply, Submodule.coe_sub, inner_sub_right]
  rw [hsub, hid, shiftCol]
  simp [Finsupp.single_apply, eq_comm]
