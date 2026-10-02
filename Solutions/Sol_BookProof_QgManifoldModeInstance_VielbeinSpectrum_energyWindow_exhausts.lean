-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.VielbeinSpectrum.energyWindow_exhausts
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)

set_option maxHeartbeats 1000000 in
theorem solution (F : Finset ι) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ S.energyWindow n := by

  classical
  refine eventually_atTop.mpr ⟨F.sup fun a => ⌈S.mu a⌉₊, fun n hn a ha => ?_⟩
  have h1 : S.mu a ≤ ((⌈S.mu a⌉₊ : ℕ) : ℝ) := Nat.le_ceil _
  have h2 : (⌈S.mu a⌉₊ : ℕ) ≤ F.sup fun a => ⌈S.mu a⌉₊ :=
    Finset.le_sup (f := fun a : ι => ⌈S.mu a⌉₊) ha
  have h3 : ((⌈S.mu a⌉₊ : ℕ) : ℝ) ≤ ((F.sup fun a => ⌈S.mu a⌉₊ : ℕ) : ℝ) := Nat.cast_le.mpr h2
  have h4 : ((F.sup fun a => ⌈S.mu a⌉₊ : ℕ) : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hn
  simp only [energyWindow, Set.mem_setOf_eq]
  linarith
