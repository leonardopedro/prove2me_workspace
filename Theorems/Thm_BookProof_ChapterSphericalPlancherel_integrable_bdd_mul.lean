-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.integrable_bdd_mul
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.integrable_bdd_mul (G : ℝ → ℂ) (hG : Integrable G) (u : ℝ → ℝ) (hu : Continuous u)
    (hb : ∀ x, |u x| ≤ 1) : Integrable (fun x : ℝ => (u x : ℂ) * G x) := by sorry
