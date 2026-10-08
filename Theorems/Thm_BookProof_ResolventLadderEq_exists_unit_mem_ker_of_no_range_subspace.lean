-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.exists_unit_mem_ker_of_no_range_subspace
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadderEq.exists_unit_mem_ker_of_no_range_subspace (P : F →L[ℂ] F) {k : ℕ}
    (hex : ¬ ∃ S₀ : Submodule ℂ F,
      Module.finrank ℂ S₀ = k + 1 ∧ (S₀ : Set F) ⊆ Set.range P)
    {W : Submodule ℂ F} (hW : Module.finrank ℂ W = k + 1) :
    ∃ x ∈ W, ‖x‖ = 1 ∧ P x = 0 := by sorry
