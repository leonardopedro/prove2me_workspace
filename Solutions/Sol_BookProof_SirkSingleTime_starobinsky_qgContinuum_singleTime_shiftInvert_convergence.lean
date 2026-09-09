-- Generated from ChapterSirkSingleTimeShift.lean — solution of BookProof.SirkSingleTime.starobinsky_qgContinuum_singleTime_shiftInvert_convergence
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Theorems.Thm_BookProof_SirkSingleTime_qgOuterFock_singleTime_shiftInvert_convergence
open BookProof.SirkSingleTime









open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}











open BookProof.ChapterSirkEndToEnd BookProof.ChapterH4 BookProof.ChapterH6

variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']



open BookProof.QgTruncationResolvent BookProof.FarisLavine BookProof.EsaClosure
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL BookProof.QgOuterFockCoreFL

variable {ι : Type*}




open BookProof.QgContinuumModeInstance

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec CMode,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec CMode) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_singleTime_shiftInvert_convergence (starobinskyWall M alpha halpha)
      (qgContinuumModes g) momWindow momWindow_exhausts
