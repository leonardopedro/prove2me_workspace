-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.smul_add_sum_comm
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
theorem solution {M : Type*} [AddCommMonoid M] [Module ℂ M] {ι : Type*} [Fintype ι]
    (c : ℂ) (A C : ι → M) : c • ((∑ p, A p) + ∑ p, C p) = ∑ p, c • (A p + C p) := by

  rw [← Finset.sum_add_distrib, Finset.smul_sum]
