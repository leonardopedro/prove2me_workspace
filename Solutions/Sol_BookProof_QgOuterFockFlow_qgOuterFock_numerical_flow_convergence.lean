-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.qgOuterFock_numerical_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_qgOuterFock_stone_flow
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendsto
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendstoUniformlyOn
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (U : ℝ → (Sec ι →L[ℂ] Sec ι)),
      IsSelfAdjointExtension (secData W Q).ext T.op ∧ IsStoneFlow T U ∧
        ∀ S : ℕ → UnboundedSelfAdjoint (Sec ι), StrongResolventConvergence T S →
          ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
            (TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
                (Set.Icc (-T₀) T₀)
              ∧ ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v))) := by

  obtain ⟨T, U, hext, hflow⟩ := qgOuterFock_stone_flow W Q
  exact ⟨T, U, hext, hflow, fun S hres v T₀ hT₀ =>
    ⟨trotterKato_tendstoUniformlyOn T S hres v hT₀, fun t => trotterKato_tendsto T S hres v t⟩⟩
