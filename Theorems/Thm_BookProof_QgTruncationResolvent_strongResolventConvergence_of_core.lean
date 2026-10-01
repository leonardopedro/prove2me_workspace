-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section


theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_core {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {Hn : ℕ → (D →ₗ[ℂ] F)} {T : UnboundedSelfAdjoint F} {S : ℕ → UnboundedSelfAdjoint F}
    (hesa : EssentiallySelfAdjointOn D Hc) (hT : IsSelfAdjointExtension Hc T.op)
    (hS : ∀ n, IsSelfAdjointExtension (Hn n) (S n).op)
    (hconv : ∀ x : D, Tendsto (fun n => Hn n x) atTop (𝓝 (Hc x))) :
    StrongResolventConvergence T S := by sorry
