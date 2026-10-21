-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.isGraphCore_of_esa
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_SmFarisLavine_norm_le_norm_shift_I
import Theorems.Thm_BookProof_FarisLavine_dense_range_of_deficiencyTrivialAt
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_dom_le_range
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
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
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    (hesa : EssentiallySelfAdjointOn P.dom P.op) :
    IsGraphCore (friedrichsComparison P hdense) P.dom := by

  set C : Comparison F := friedrichsComparison P hdense with hC
  have hle : P.dom ≤ C.dom := fun _ hv => FormDom.dom_le_range P hv
  have hext : ∀ y : P.dom, C.op ⟨(y : F), hle y.2⟩ = P.op y := by
    intro y
    obtain ⟨h, hh⟩ := friedrichsComparison_extends P hdense y
    exact hh
  refine ⟨hle, ?_⟩
  intro x ε hε
  have hconj : (starRingEnd ℂ) (-Complex.I) = Complex.I := by simp
  have hdr : Dense (Set.range fun y : P.dom => P.op y - (-Complex.I) • (y : F)) :=
    dense_range_of_deficiencyTrivialAt P.op (-Complex.I) (by rw [hconj]; exact hesa.1)
  obtain ⟨g, hgball, y, hy⟩ :=
    Metric.dense_iff.mp hdr (C.op x - (-Complex.I) • (x : F)) (ε / 2) (by positivity)
  have hdist : ‖g - (C.op x - (-Complex.I) • (x : F))‖ < ε / 2 := by
    have hball := Metric.mem_ball.mp hgball
    rwa [dist_eq_norm] at hball
  refine ⟨⟨(y : F), hle y.2⟩, y.2, ?_, ?_⟩
  · have hb := norm_le_norm_shift_I C.op C.sym (⟨(y : F), hle y.2⟩ - x)
    have hkey : C.op (⟨(y : F), hle y.2⟩ - x)
        - (-Complex.I) • ((⟨(y : F), hle y.2⟩ - x : C.dom) : F)
        = g - (C.op x - (-Complex.I) • (x : F)) := by
      have hcoe : ((⟨(y : F), hle y.2⟩ - x : C.dom) : F) = (y : F) - (x : F) := rfl
      rw [map_sub, hext y, hcoe, ← hy]
      module
    rw [hkey] at hb
    have hb' : ‖((y : F)) - (x : F)‖ ≤ ‖g - (C.op x - (-Complex.I) • (x : F))‖ := hb
    linarith
  · have hkey : C.op (⟨(y : F), hle y.2⟩ - x)
        - (-Complex.I) • ((⟨(y : F), hle y.2⟩ - x : C.dom) : F)
        = g - (C.op x - (-Complex.I) • (x : F)) := by
      have hcoe : ((⟨(y : F), hle y.2⟩ - x : C.dom) : F) = (y : F) - (x : F) := rfl
      rw [map_sub, hext y, hcoe, ← hy]
      module
    have hb := norm_le_norm_shift_I C.op C.sym (⟨(y : F), hle y.2⟩ - x)
    rw [hkey] at hb
    have hb' : ‖((y : F)) - (x : F)‖ ≤ ‖g - (C.op x - (-Complex.I) • (x : F))‖ := hb
    have hmapsub : C.op (⟨(y : F), hle y.2⟩ - x)
        = C.op ⟨(y : F), hle y.2⟩ - C.op x := map_sub _ _ _
    rw [hmapsub] at hkey
    have hsplit : C.op ⟨(y : F), hle y.2⟩ - C.op x
        = (g - (C.op x - (-Complex.I) • (x : F)))
          + (-Complex.I) • (((y : F)) - (x : F)) := by
      have hcoe : ((⟨(y : F), hle y.2⟩ - x : C.dom) : F) = (y : F) - (x : F) := rfl
      rw [hcoe] at hkey
      exact sub_eq_iff_eq_add.mp hkey
    have hns : ‖(-Complex.I) • (((y : F)) - (x : F))‖ = ‖((y : F)) - (x : F)‖ := by
      rw [norm_smul]
      simp
    calc ‖C.op ⟨(y : F), hle y.2⟩ - C.op x‖
        ≤ ‖g - (C.op x - (-Complex.I) • (x : F))‖
          + ‖(-Complex.I) • (((y : F)) - (x : F))‖ := by
          rw [hsplit]; exact norm_add_le _ _
      _ = ‖g - (C.op x - (-Complex.I) • (x : F))‖ + ‖((y : F)) - (x : F)‖ := by rw [hns]
      _ < ε := by linarith
