-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.lagSectorHam_esa
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_lagIdx_injective
import Theorems.Thm_BookProof_NsFullLagrangianEsa_realCoeff_lagForms
import Theorems.Thm_BookProof_NsFullLagrangianEsa_lagSectorHam_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 36)) (lagSectorHam lam lam' mu gg n) := by

  rw [lagSectorHam_eq_weylPoly]
  exact weylPoly_esa (lagIdx_injective n) (realCoeff_lagForms lam lam' mu gg n)
