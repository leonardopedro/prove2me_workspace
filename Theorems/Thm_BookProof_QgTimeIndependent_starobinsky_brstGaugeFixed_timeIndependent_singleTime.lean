-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.starobinsky_brstGaugeFixed_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {ι : Type*}



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.starobinsky_brstGaugeFixed_timeIndependent_singleTime (M alpha : ℝ)
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
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
