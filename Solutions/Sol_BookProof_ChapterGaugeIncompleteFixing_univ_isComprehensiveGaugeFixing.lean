-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.univ_isComprehensiveGaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsComprehensiveGaugeFixing G (Set.univ : Set X) := fun x => ⟨x, Set.mem_univ x, 1, one_smul G x⟩
