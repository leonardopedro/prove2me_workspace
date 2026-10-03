-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.qgOuterFock_singleTime_shiftInvert_convergence
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
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

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}
variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']
variable {ι : Type*}


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.SirkSingleTime.qgOuterFock_singleTime_shiftInvert_convergence (W : WallPot) (Q : QgModeData ι)
    (Λ : ℕ → Set ι) (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
