-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.ham_eq_ham_zero_add
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Theorems.Thm_BookProof_ScalaronFiberFL_hamS_apply
import Theorems.Thm_BookProof_ScalaronFiberFL_ham_eq_toLp
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : ccDomain ℝ) :
    W.ham s u = W.ham 0 u + (s : ℂ) • (u : L2R) := by

  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective u
  rw [ham_eq_toLp, ham_eq_toLp, ccEquiv_coe]
  have hS : hamS W s f = hamS W 0 f + (s : ℂ) • (f : 𝓢(ℝ, ℂ)) := by
    refine SchwartzMap.ext fun x => ?_
    simp only [SchwartzMap.add_apply, SchwartzMap.smul_apply, hamS_apply, smul_eq_mul,
      WallPot.pot]
    push_cast
    ring
  rw [hS]
  have h1 := map_add (toLpCLM ℂ ℂ 2 (volume : Measure ℝ)) (hamS W 0 f)
    ((s : ℂ) • (f : 𝓢(ℝ, ℂ)))
  have h2 := map_smul (toLpCLM ℂ ℂ 2 (volume : Measure ℝ)) ((s : ℂ)) (f : 𝓢(ℝ, ℂ))
  rw [show ((hamS W 0 f + (s : ℂ) • (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ))
      = toLpCLM ℂ ℂ 2 (volume : Measure ℝ) (hamS W 0 f + (s : ℂ) • (f : 𝓢(ℝ, ℂ))) from rfl,
    h1, h2]
  rfl
