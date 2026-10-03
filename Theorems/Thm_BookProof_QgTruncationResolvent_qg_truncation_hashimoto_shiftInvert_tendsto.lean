-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.qg_truncation_hashimoto_shiftInvert_tendsto
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open `BookProof.HashimotoShiftInvert`.
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section


theorem BookProof.QgTruncationResolvent.qg_truncation_hashimoto_shiftInvert_tendsto (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) ∧
        (∀ n, IsShiftInvertC (S n).op Complex.I (-((S n).resCLM 1))) ∧
        ∀ u : Sec ι, Tendsto (fun n => -((S n).resCLM 1 u)) atTop (𝓝 (-(T.resCLM 1 u))) := by sorry
