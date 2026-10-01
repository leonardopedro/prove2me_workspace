-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section


theorem BookProof.QgTruncationResolvent.strongResolventConvergence_of_dense {T : UnboundedSelfAdjoint F}
    {S : ℕ → UnboundedSelfAdjoint F} {G : Set F} (hG : Dense G)
    (h : ∀ y ∈ G, Tendsto (fun n => (S n).resCLM 1 y) atTop (𝓝 (T.resCLM 1 y))) :
    StrongResolventConvergence T S := by sorry
