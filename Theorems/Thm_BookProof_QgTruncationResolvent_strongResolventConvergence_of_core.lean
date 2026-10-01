-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_core
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_core {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {Hn : ℕ → (D →ₗ[ℂ] F)} {T : UnboundedSelfAdjoint F} {S : ℕ → UnboundedSelfAdjoint F}
    (hesa : EssentiallySelfAdjointOn D Hc) (hT : IsSelfAdjointExtension Hc T.op)
    (hS : ∀ n, IsSelfAdjointExtension (Hn n) (S n).op)
    (hconv : ∀ x : D, Tendsto (fun n => Hn n x) atTop (𝓝 (Hc x))) :
    StrongResolventConvergence T S := by sorry
