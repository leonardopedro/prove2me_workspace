-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.contDiff_starobinskyV
--
-- This node exists because `Definitions/Def_ChapterScalaronFiberFL.lean` needs the smoothness of
-- the Einstein-frame scalaron potential as a *Proved* platform theorem: a Definitions module may
-- import a Theorems module, but only once that theorem is Proved.  The declaration is hollowed out
-- of the definitions layer (`Def_ChapterScalaronCoreEsa` documents it and does not declare it), so
-- it has to live in the theorem layer.
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky


open Filter Topology


noncomputable section

theorem BookProof.ScalaronEsa.contDiff_starobinskyV (M alpha : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun phi : ℝ => starobinskyV M alpha phi) := by sorry
