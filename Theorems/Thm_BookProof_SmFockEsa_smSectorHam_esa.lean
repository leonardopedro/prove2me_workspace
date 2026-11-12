-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.smSectorHam_esa
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavineCore
import Mathlib

open MvPolynomial
open BookProof.FarisLavine
open BookProof.SmOuterFock BookProof.SmHamiltonian
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.SmFockEsa.smSectorHam_esa (P : SmParams) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 163)) (smSectorHam P n) := by sorry
