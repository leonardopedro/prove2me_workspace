-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.qgOuterFock_numerical_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_qgOuterFock_stone_flow
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendsto
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendstoUniformlyOn
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.ChapterStoneResolvent
open BookProof.StoneBridge

noncomputable section

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)

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
