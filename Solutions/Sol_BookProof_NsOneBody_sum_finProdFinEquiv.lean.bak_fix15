-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.sum_finProdFinEquiv
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
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
theorem solution {M : Type*} [AddCommMonoid M] {a b : ℕ} (f : Fin (a * b) → M) :
    ∑ x, f x = ∑ p : Fin a, ∑ i : Fin b, f (finProdFinEquiv (p, i)) := by

  rw [← Equiv.sum_comp finProdFinEquiv f, Fintype.sum_prod_type]
