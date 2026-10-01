-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_weak_eq
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

tCc_apply {g : ℝ → ℝ} (hg : IsTestFun g) (x : ℝ) :
    ((testCc hg : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x = ((g x : ℝ) : ℂ) := rfl

theorem BookProof.ScalaronWallEsa.wallHam_weak_eq (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure ℝ))
    (hu : ∀ v : ccDomain ℝ,
      (inner ℂ (wallHam V hV v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    {g : ℝ → ℝ} (hg := by sorry
