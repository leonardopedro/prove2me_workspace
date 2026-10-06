-- Generated from ChapterQuantizationWeyl.lean — theorem BookProof.QuantizationWeyl.sum_XYZ
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl


open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

theorem BookProof.QuantizationWeyl.sum_XYZ (a b : ℝ) :
    a • Xgen + b • Ygen + (a * b / 2) • Zgen = Ngen a b (a * b / 2) := by sorry
