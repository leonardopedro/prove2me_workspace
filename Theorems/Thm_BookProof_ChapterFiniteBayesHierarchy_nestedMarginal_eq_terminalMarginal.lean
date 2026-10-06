-- Generated from ChapterFiniteBayesHierarchy.lean — theorem BookProof.ChapterFiniteBayesHierarchy.nestedMarginal_eq_terminalMarginal
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition
open BookProof.ChapterFiniteBayesHierarchy

variable {S : Type*} [Fintype S] [DecidableEq S]


open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition


theorem BookProof.ChapterFiniteBayesHierarchy.nestedMarginal_eq_terminalMarginal (ks : List (S → S → ℝ))
    (likelihood : S → ℝ) :
    nestedMarginal ks likelihood =
      terminalMarginal (collapseKernels ks) likelihood := by sorry
