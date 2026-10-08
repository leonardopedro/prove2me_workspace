-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.ladderH_eq_zero
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanGeneralHop



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}
variable {ι : Type*} [Fintype ι] {lam : (Fin d →₀ ℕ) → ℝ} {p m : ι → (Fin d →₀ ℕ)}
  {c c' : ι → (Fin d →₀ ℕ) → ℝ} {w : ι → ℂ} {z : ℂ}

theorem BookProof.CarlemanGeneralHop.ladderH_eq_zero {B Camp : ℝ} (hz : z.im ≠ 0) (hCamp : 0 ≤ Camp)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hp : ∀ (h : ι) (k : Fin d), p h k ≤ 2) (hm1 : ∀ (h : ι) (k : Fin d), m h k ≤ 1)
    (hcomp : ∀ (h : ι) (b : Fin d →₀ ℕ), (∀ k, m h k ≤ b k) →
      c' h (hshift (p h) (m h) b) = c h b)
    (hvanL : ∀ (h : ι) (a : Fin d →₀ ℕ), ¬ (∀ k, p h k ≤ a k) → c' h a = 0)
    (hvanR : ∀ (h : ι) (a : Fin d →₀ ℕ), ¬ (∀ k, m h k ≤ a k) → c h a = 0)
    (hbnd : ∀ (h : ι) (a : Fin d →₀ ℕ) (N : ℕ), (∀ k, a k ≤ N) →
      |c h a| ≤ Camp * ((N : ℝ) + 1))
    (hrec : LadderRecH u lam p m c c' w z) : ∀ a, u a = 0 := by sorry
