-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.secHam_truncate_eventually_eq
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgTruncationResolvent_secHam_truncate_eq_of_band
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) (x : secCore (ι := by

  obtain ⟨P, hP1, hP2⟩ := exists_band Q x
  filter_upwards [hexh P] with n hn
  exact secHam_truncate_eq_of_band W Q (Λ n) hP1 hP2 hn
