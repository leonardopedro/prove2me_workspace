-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.smFockHam_esa
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterFarisLavineCore
import Mathlib

open MvPolynomial
open BookProof.FarisLavine
open BookProof.SmOuterFock BookProof.SmHamiltonian

noncomputable section

theorem BookProof.SmFockEsa.smFockHam_esa (P : SmParams) :
    EssentiallySelfAdjointOn smFockCore (smFockHam P) := by sorry
