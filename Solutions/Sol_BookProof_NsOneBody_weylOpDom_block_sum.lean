-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.weylOpDom_block_sum
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_sum_finProdFinEquiv
import Theorems.Thm_BookProof_NsOneBody_smul_add_sum_comm
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} {a b c : ℕ} (pi : Fin (a * b) → D →ₗ[ℂ] D)
    (Bf : Fin (a * c) → D →ₗ[ℂ] D) :
    weylOpDom pi Bf
      = ∑ p : Fin a, weylOpDom (fun i : Fin b => pi (finProdFinEquiv (p, i)))
          (fun r : Fin c => Bf (finProdFinEquiv (p, r))) := by

  have hpi : (∑ m, (pi m).comp (pi m))
      = ∑ p : Fin a, ∑ i : Fin b,
          (pi (finProdFinEquiv (p, i))).comp (pi (finProdFinEquiv (p, i))) :=
    sum_finProdFinEquiv (fun m => (pi m).comp (pi m))
  have hBf : (∑ m, (Bf m).comp (Bf m))
      = ∑ p : Fin a, ∑ r : Fin c,
          (Bf (finProdFinEquiv (p, r))).comp (Bf (finProdFinEquiv (p, r))) :=
    sum_finProdFinEquiv (fun m => (Bf m).comp (Bf m))
  simp only [weylOpDom]
  rw [hpi, hBf]
  exact smul_add_sum_comm (((1 / 2 : ℝ)) : ℂ)
    (fun p : Fin a => ∑ i : Fin b,
      (pi (finProdFinEquiv (p, i))).comp (pi (finProdFinEquiv (p, i))))
    (fun p : Fin a => ∑ r : Fin c,
      (Bf (finProdFinEquiv (p, r))).comp (Bf (finProdFinEquiv (p, r))))
