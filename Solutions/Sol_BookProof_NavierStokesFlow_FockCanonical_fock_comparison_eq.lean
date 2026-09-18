-- Generated from ChapterNavierStokesFockCanonical.lean — solution of BookProof.NavierStokesFlow.FockCanonical.fock_comparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_ann_cre_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_cre_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_mode_comparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_coe_sum_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) :
    (lpFiniteModes (Occ d)).subtype.comp
        ((∑ i, ((mom κ i).comp (mom κ i) + (drift κ i).comp (drift κ i))) + LinearMap.id)
      = (diagMax (fockSym κ)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by

  refine LinearMap.ext fun x => lp.ext (funext fun α => ?_)
  have hmode : ∀ i : Fin d,
      ((((mom κ i) ((mom κ i) x) + (drift κ i) ((drift κ i) x) : lpFiniteModes (Occ d)) :
          L2I (Occ d)) : Occ d → ℂ) α
        = ((κ i * (2 * (α i : ℝ) + 1) : ℝ) : ℂ)
          * ((x : L2I (Occ d)) : Occ d → ℂ) α := by
    intro i
    have hcomp := congrArg
      (fun T : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) =>
        (((T x : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α)
      (mode_comparison_eq i (hκ i))
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
      Submodule.coe_add, Submodule.coe_smul, lp.coeFn_add, lp.coeFn_smul, Pi.add_apply,
      Pi.smul_apply, smul_eq_mul, ann_cre_coe, cre_ann_coe] at hcomp
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    rw [hcomp]
    push_cast
    ring
  simp only [LinearMap.comp_apply, LinearMap.add_apply, Submodule.subtype_apply,
    LinearMap.id_apply, LinearMap.coe_sum, Finset.sum_apply, Submodule.coe_add,
    lp.coeFn_add, Pi.add_apply, diagMax_coe, Submodule.inclusion_apply]
  rw [coe_sum_apply Finset.univ
    (fun i => (mom κ i) ((mom κ i) x) + (drift κ i) ((drift κ i) x)) α,
    Finset.sum_congr rfl (fun i _ => hmode i), ← Finset.sum_mul]
  simp only [fockSym]
  push_cast
  ring
