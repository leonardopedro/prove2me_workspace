-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.qgOuterFock_numerical_flow_convergence
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint
open BookProof.StoneBridge

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

theorem BookProof.QgOuterFockFlow.qgOuterFock_numerical_flow_convergence :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (U : ℝ → (Sec ι →L[ℂ] Sec ι)),
      IsSelfAdjointExtension (secData W Q).ext T.op ∧ IsStoneFlow T U ∧
        ∀ S : ℕ → UnboundedSelfAdjoint (Sec ι), StrongResolventConvergence T S →
          ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
            (TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
                (Set.Icc (-T₀) T₀)
              ∧ ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v))) := by sorry
