-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.starobinsky_brstGaugeFixed_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Theorems.Thm_BookProof_QgTimeIndependent_qgOuterFock_timeIndependent_singleTime
import Theorems.Thm_BookProof_QgBrstDerivativeGauge_gaugeReduce_gram
import Theorems.Thm_BookProof_QgTruncationResolvent_momWindow_exhausts
open BookProof.QgTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      (∀ x y : CMode, x.1 = y.1 →
          ∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
              (starRingEnd ℂ) (gaugeReduce (extTorsionCoef x.1 mu nu i) x)
                * gaugeReduce (extTorsionCoef x.1 mu nu i) y
            = contTorsionGram x y) ∧
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Sec CMode), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Sec CMode), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → Sec CMode, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec CMode,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec CMode) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by

  obtain ⟨T, S, h⟩ := qgOuterFock_timeIndependent_singleTime (starobinskyWall M alpha halpha)
    (qgContinuumModes g) momWindow momWindow_exhausts
  exact ⟨T, S, fun x y hxy => gaugeReduce_gram x y hxy, h⟩
