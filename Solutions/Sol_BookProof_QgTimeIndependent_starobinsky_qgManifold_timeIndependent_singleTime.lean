-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.starobinsky_qgManifold_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Theorems.Thm_BookProof_QgTimeIndependent_qgOuterFock_timeIndependent_singleTime
import Theorems.Thm_BookProof_QgManifoldModeInstance_VielbeinSpectrum_energyWindow_exhausts
open BookProof.QgTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ)
    (halpha : 0 < alpha) (Sp : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (Sp.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (Sp.modes g) (Sp.energyWindow n))) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Sec ι), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Sec ι), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → Sec ι, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_timeIndependent_singleTime (starobinskyWall M alpha halpha)
      (Sp.modes g) Sp.energyWindow Sp.energyWindow_exhausts
