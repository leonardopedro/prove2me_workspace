-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.momWindow_exhausts
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (F : Finset CMode) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ momWindow n := by

  classical
  refine eventually_atTop.mpr ⟨F.sup fun a => ⌈momSq a.1⌉₊, fun n hn a ha => ?_⟩
  have h1 : momSq a.1 ≤ ((⌈momSq a.1⌉₊ : ℕ) : ℝ) := Nat.le_ceil _
  have h2 : (⌈momSq a.1⌉₊ : ℕ) ≤ F.sup fun a => ⌈momSq a.1⌉₊ :=
    Finset.le_sup (f := fun a : CMode => ⌈momSq a.1⌉₊) ha
  have h3 : ((⌈momSq a.1⌉₊ : ℕ) : ℝ) ≤ ((F.sup fun a => ⌈momSq a.1⌉₊ : ℕ) : ℝ) :=
    Nat.cast_le.mpr h2
  have h4 : ((F.sup fun a => ⌈momSq a.1⌉₊ : ℕ) : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hn
  simp only [momWindow, Set.mem_setOf_eq]
  linarith
