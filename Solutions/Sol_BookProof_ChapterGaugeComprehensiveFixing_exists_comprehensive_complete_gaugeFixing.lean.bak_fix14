-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.exists_comprehensive_complete_gaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_orbitRepresentatives_isComprehensiveGaugeFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_orbitRepresentatives_isCompleteGaugeFixing_prime
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ S : Set X, IsComprehensiveGaugeFixing G S ∧ IsCompleteGaugeFixing' G S :=
  ⟨orbitRepresentatives G, orbitRepresentatives_isComprehensiveGaugeFixing G,
      orbitRepresentatives_isCompleteGaugeFixing_prime G⟩
