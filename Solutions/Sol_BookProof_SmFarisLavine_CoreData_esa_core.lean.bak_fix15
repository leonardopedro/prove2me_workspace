-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.CoreData.esa_core
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_restrict_of_graph_core
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_core
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_norm_le
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
theorem solution (d : CoreData F) (hsym : SymmetricOn d.C₀ d.H₀) {c : ℝ}
    (hc : 0 ≤ c) (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by

  have hD : EssentiallySelfAdjointOn d.C.dom d.ext :=
    d.ext_essentiallySelfAdjointOn hsym hc hcomm
  have hcore : ∀ (x : d.C.dom) (ε : ℝ), 0 < ε → ∃ y : d.C.dom, (y : F) ∈ d.C₀ ∧
      ‖(y : F) - (x : F)‖ < ε ∧ ‖d.ext y - d.ext x‖ < ε := by
    intro x ε hε
    have hK : 0 ≤ d.K := d.hK
    set δ : ℝ := min ε (ε / (2 * d.K + 1)) with hδdef
    have hpos : (0 : ℝ) < 2 * d.K + 1 := by positivity
    have hδ : 0 < δ := lt_min hε (by positivity)
    obtain ⟨y, hyC, hy1, hy2⟩ := d.gc.approx x δ hδ
    refine ⟨y, hyC, lt_of_lt_of_le hy1 (min_le_left _ _), ?_⟩
    have hlin : d.ext y - d.ext x = d.ext (y - x) := by rw [map_sub]
    have hcoe : ((y - x : d.C.dom) : F) = (y : F) - (x : F) := rfl
    have hop : d.C.op (y - x) = d.C.op y - d.C.op x := by rw [map_sub]
    have hbd := d.ext_norm_le (y - x)
    rw [hop, hcoe] at hbd
    have htri : ‖(d.C.op y - d.C.op x) + ((y : F) - (x : F))‖
        ≤ ‖d.C.op y - d.C.op x‖ + ‖(y : F) - (x : F)‖ := norm_add_le _ _
    have hsum : ‖d.C.op y - d.C.op x‖ + ‖(y : F) - (x : F)‖ ≤ 2 * δ := by linarith
    have hfin : ‖d.ext (y - x)‖ ≤ d.K * (2 * δ) :=
      hbd.trans (mul_le_mul_of_nonneg_left (htri.trans hsum) hK)
    have hδ2 : δ ≤ ε / (2 * d.K + 1) := min_le_right _ _
    have h1 : (2 * d.K + 1) * δ ≤ ε := by
      rw [le_div_iff₀ hpos] at hδ2
      linarith
    have hlt : d.K * (2 * δ) < ε := by nlinarith
    rw [hlin]
    exact lt_of_le_of_lt hfin hlt
  have hres := essentiallySelfAdjointOn_restrict_of_graph_core d.gc.le d.ext hcore hD
  have hid : d.ext.comp (Submodule.inclusion d.gc.le) = d.H₀ := by
    refine LinearMap.ext fun p => ?_
    simpa only [LinearMap.comp_apply, Submodule.inclusion_apply] using d.ext_core p
  rwa [hid] at hres
