-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.eulIdx_injective
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_eulMomIdx_injective
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Function.Injective (eulIdx n) := by

  intro m m' h
  simp only [eulIdx, NsFullEuler.ycoord] at h
  have h2 := finProdFinEquiv.injective h
  simp only [Prod.mk.injEq] at h2
  apply finProdFinEquiv.symm.injective
  exact Prod.ext h2.1 (eulMomIdx_injective h2.2)
