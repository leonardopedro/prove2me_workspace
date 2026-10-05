-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.fock_gap_of_one_particle_form_gap
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockNumberPreservingGap_dGamma_vac
import Theorems.Thm_BookProof_FockNumberPreservingGap_fock_gap_of_number_preserving
import Theorems.Thm_BookProof_FockNumberPreservingGap_shiftCol_opCol
import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : ∀ x : finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    dGamma (opCol b A) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re := by

  have hpos : ∀ x : finiteModeDomain b,
      0 ≤ quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x := by
    intro x
    have hval : quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x
        = quadForm ((finiteModeDomain b).subtype.comp A) x - mu * ‖(x : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
        LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_sub,
        Submodule.coe_smul, inner_sub_right, inner_smul_right, Complex.sub_re,
        Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [hval]
    linarith [hgap x]
  have hgapCol : IsPosCol (shiftCol (opCol b A) mu) := by
    rw [shiftCol_opCol]
    exact isPosCol_opCol hpos
  exact ⟨dGamma_vac _, fun u h0 => fock_gap_of_number_preserving hmu hgapCol h0⟩
