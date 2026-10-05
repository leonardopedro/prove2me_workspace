-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.sm_h_esa_of_graph_core
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_SmFarisLavine_CoreData_esa_core
import Theorems.Thm_BookProof_SmFarisLavine_sm_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
open BookProof.SmFarisLavine




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (hgc : IsGraphCore (smFlComparison P hc0) (polyGaussCore (d := 163))) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smHamiltonian P) := by

  refine CoreData.esa_core (smCoreData P hc0 hgc) (smHamiltonian_symmetricOn P)
    zero_le_one fun p => ?_
  obtain ⟨h, hx⟩ := smFlComparison_extends P hc0 p
  have hcoreN : (smCoreData P hc0 hgc).coreN p = smFlN P c0 p := hx
  have h1 : commForm (smCoreData P hc0 hgc).H₀ (smCoreData P hc0 hgc).coreN p
      = commForm (smHamiltonian P) (smFlN P c0) p :=
    commForm_congr _ _ _ _ _ _ rfl hcoreN
  have h2 : quadForm (smCoreData P hc0 hgc).coreN p = quadForm (smFlN P c0) p :=
    quadForm_congr _ _ _ _ rfl hcoreN
  rw [h1, h2]
  exact sm_commForm_le P hc0 p
